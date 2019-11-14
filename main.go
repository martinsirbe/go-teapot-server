package main

import (
	"log"
	"net/http"
	"regexp"

	"github.com/gorilla/mux"
)

func main() {
	r := mux.NewRouter()

	r.MatcherFunc(func(r *http.Request, rm *mux.RouteMatch) bool {
		match, err := regexp.MatchString("/.*", r.URL.Path)
		if err != nil {
			log.Panic(err)
		}

		return match
	}).HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusTeapot)
	})

	if err := http.ListenAndServe(":8080", r); err != nil {
		log.Panic(err)
	}
}
