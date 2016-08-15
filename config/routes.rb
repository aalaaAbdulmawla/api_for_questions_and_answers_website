require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
      scope module: :v1 do

      	resources :users, only: [:show, :create, :update, :destroy, :index] do
      		resources :questions, :only => [:create, :update, :destroy]
          member do
            get :questions
            get :answers
            get :comments
            get :favorites
            get :newest_questions
            get :newest_answers
            get :newest_votes
            get :tags
          end      
      	end

      	resources :questions, :only => [:index, :show] do
          resources :featured_questions, :only => [:create]
          resources :answers, :only => [:create]
          resources :comments, :only => [:create]
          resources :edit_suggestions, only: [:create]
          resources :tags, only: [:create, :destroy]
          member do
            put :favorite
            delete :unfavorite
            put  :vote_up, controller: :votes, question_id: true
            put  :vote_down, controller: :votes, question_id: true
            put  :remove_vote, controller: :votes, question_id: true
            get :votes
            get :question_tags,  controller: :tags
          end
          collection do
            get :no_answers
            get :no_answers_votes
            get :newest_no_answers     
            get :newest_questions
            get :under_tag
            get :unanswered
            get :newest_unanswered
            get :unanswered_votes
            get :active
          end
      	end

      	resources :answers, :only => [:show, :update] do
      		resources :comments, :only => [:create]
          member do    
            put  :vote_up, controller: :votes, answer_id: true
            put  :vote_down, controller: :votes, answer_id: true
            put  :remove_vote, controller: :votes, answer_id: true
            put :verify_answer
          end
      	end

      	resources :comments, :only => [:show] do
          member do
            put :vote_up, controller: :votes, comment_id: true
            put :vote_down, controller: :votes, comment_id: true
            put :remove_vote, controller: :votes, comment_id: true
          end       
        end

        resources :edit_suggestions, :only => [:show, :index] do
          put :approve_edit, on: :member
        end

        resources :votes, :only => [:show]
        resources :featured_questions, only: :show      
        resources :tags, :only => [:index] do
          collection do
            get :newest
            get :search
          end
        end
        resources :sessions, :only => [:create, :destroy]
        mount Resque::Server.new, at: "/resque"

      end 
  end

end