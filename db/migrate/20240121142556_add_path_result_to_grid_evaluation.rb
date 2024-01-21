class AddPathResultToGridEvaluation < ActiveRecord::Migration[7.1]
  def change
    add_column :grid_evaluations, :result_path, :text
  end
end
