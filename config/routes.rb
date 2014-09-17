Rails.application.routes.draw do

  root to: "words#index"
  resources :words, except: [:edit, :new]
  resources :word_template
end
