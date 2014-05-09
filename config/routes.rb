TestCenter::Application.routes.draw do

  get "examples/delete_case"
  get "examples/delete_all_case"
  get "divisor/edit"
  resources :examples do
    member do
      get 'get_info'
      post 'edit_case'
      post 'upload_img'
      post 'edit_evidence'
    end
    collection do
      post 'set_default'
    end
  end

  get "project/index"
  get "project/get_project"
  get "project/find_project_group"
  get "attachments/upload"
  get "test_file/download_testfile"

  resources :project do
    member do
      get 'get_info'
      post 'edit_project'
      get 'get_identifer'
    end
  end

  resources :test_file do
    member do
      get 'get_info'
      post 'edit_test_file'
    end
  end

  resources :factor do
    member do
      get 'get_info'
      get 'get_info_update'
      get 'get_info_create'
      post 'edit'
    end
  end

  resources :divisor do
    member do
      get 'get_info_update'
      get 'get_info_create'
      post 'edit'
    end
  end

  resources :examples do
    member do
      get 'cancel_edit'
      get 'able_edit'
    end
  end

  resources :versions do
    member do
      get 'index'
      get 'get_info'
      post 'update_version'
      post 'create_version'
    end
  end

  resources :users do
    member do
      get 'index'
      get 'get_info'
      post 'update_user'
      post 'create_user'
    end
  end

  resources :groups do
    member do
      get 'index'
      get 'get_info'
      post 'update_group'
      post 'create_group'
    end
  end
  # resources :test_file
  # resources :factor
  # resources :divisor
  # resources :rule


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'project#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
    match ':controller(/:action(/:id))(.:format)'
end
