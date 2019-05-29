class CreateDislikes < ActiveRecord::Migration[5.0]
  def change
    create_table :dislikes do |t|
        t.integer :user_id
        t.integer :song_id
    end
  end
end

