package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func main() {
	fmt.Println("started server....")
	http.HandleFunc("/", index)
	http.ListenAndServe(":3000", nil)
}

type Info struct {
	ID    string  `json:"id"`
	Name  string `json:"name"`
	Email string `json:"email"`
}

func index(w http.ResponseWriter, r *http.Request) {
	var i = Info{
		Name:  "steve",
		Email: "steve@test.com",
		ID:    "2131256678879",
	}

	js, err := json.Marshal(i)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(js)
}
