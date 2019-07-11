class CreateAgendas < ActiveRecord::Migration[5.0]
  def change
    create_table :agendas do |t|
      t.integer :user_id
      t.integer :task_id
    end
  end
end
