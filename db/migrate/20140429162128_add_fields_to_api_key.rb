class AddFieldsToApiKey < ActiveRecord::Migration
  def change
    add_column  :api_keys, :token, :string
    add_index   :api_keys, :token
  end
end
