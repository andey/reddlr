ActiveAdmin.register Sub do
  controller do
    def permitted_params
      params.permit(:sub => [:name, :css, :js])
    end
  end
end
