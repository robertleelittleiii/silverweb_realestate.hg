class AddRealestateFieldsToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :re_search_type, :string
    add_column :menus, :re_search_term, :string
    add_column :menus, :re_search_param, :string
    add_column :menus, :re_search_class, :string
  end
end
