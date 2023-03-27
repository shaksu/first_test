Rails.application.routes.draw do
  # scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users

    root 'tasks#index' # controller - action
    get 'tasks/index'

    delete 'tasks/destroy_all_done'

    put 'tasks/clear_all_done'

    get 'tasks/index_subj'
    get 'tasks/index_deadline'
    get 'tasks/index_cleared'
    get 'tasks/index_all'
    get 'tasks/index_your'

    resources :tasks do
      put :complete, on: :member
      put :uncomplete, on: :member
      put :complete_in_deadline, on: :member
      put :complete_in_subj, on: :member
      put :uncomplete_in_subj, on: :member
      put :return_done, on: :member
    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
      #end
end
