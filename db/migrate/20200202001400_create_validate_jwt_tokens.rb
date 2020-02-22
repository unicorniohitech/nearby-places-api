class CreateValidateJwtTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :validate_jwt_tokens do |t|
      t.string :token
      
      t.timestamps
    end
  end
end
