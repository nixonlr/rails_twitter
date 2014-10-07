class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_handle
      t.string :token
      t.string :token_secret

      t.timestamps
    end
  end
end
