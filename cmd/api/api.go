package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/niteshchandra7/go_stripe/internal/driver"
	"github.com/niteshchandra7/go_stripe/internal/models"
)

const (
	version = "1"
)

type config struct {
	port int
	env  string
	db   struct {
		dsn string
	}
	stripe struct {
		secret string
		key    string
	}
}

type application struct {
	config   config
	infoLog  *log.Logger
	errorLog *log.Logger
	version  string
	DB       models.DBModel
}

func (app *application) serve() error {
	srv := http.Server{
		Addr:              fmt.Sprintf(":%d", app.config.port),
		Handler:           app.routes(),
		IdleTimeout:       30 * time.Second,
		ReadTimeout:       10 * time.Second,
		ReadHeaderTimeout: 5 * time.Second,
		WriteTimeout:      5 * time.Second,
	}
	app.infoLog.Printf("Starting backend server in %s mode on port %d", app.config.env, app.config.port)
	return srv.ListenAndServe()
}

func main() {
	// err := godotenv.Load("./cmd/api/.env")
	// if err != nil {
	// 	fmt.Println(err)
	// 	return
	// }
	var cfg config
	flag.IntVar(&cfg.port, "port", 4001, "server port to listen on")
	flag.StringVar(&cfg.env, "env", "development", "application environment {deveopment | production | maintenance}")

	flag.Parse()

	cfg.stripe.key = os.Getenv("SECRET_KEY")
	cfg.stripe.secret = os.Getenv("STRIPE_SECRET")

	infoLog := log.New(os.Stdout, "INFO\t", log.Ldate|log.Ltime)
	errorLog := log.New(os.Stdout, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)

	conn, err := driver.OpenDB(os.Getenv("DSN"))
	if err != nil {
		errorLog.Panic(err)
	}
	defer conn.Close()
	infoLog.Println("successfully connected to maria_db")

	app := &application{
		config:   cfg,
		infoLog:  infoLog,
		errorLog: errorLog,
		version:  version,
		DB:       models.DBModel{DB: conn},
	}

	err = app.serve()
	if err != nil {
		log.Fatal(err)
	}
}
