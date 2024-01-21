class CreateGridEvaluations < ActiveRecord::Migration[7.1]
  def change
    create_table :grid_evaluations do |t|
      t.string :grid
      t.boolean :result

      t.timestamps
    end
  end
end
