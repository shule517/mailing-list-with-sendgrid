Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root to: 'mail_news#index'

  get 'mail_news/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
