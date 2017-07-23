Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root to: 'homes#index'

  get 'mail_news' => 'mail_news#index'
  post 'mail_news' => 'mail_news#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
