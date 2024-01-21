class GridEvaluation < ApplicationRecord
  before_save :check_conductive_path

  def self.random_grid(n)
    Array.new(n) { Array.new(n) { rand(0..1) }.join }.join("\n")
  end

  def check_conductive_path
    self.result = conductive_path?
  end

  def conductive_path?
    grid_array = self.grid.split("\n").map { |row| row.split('').map(&:to_i) }
    queue = []
    max_row = grid_array.length
    max_col = grid_array[0].length

    # 將第一行中的每個1加入隊列
    grid_array[0].each_with_index do |val, col|
      queue.push([0, col]) if val == 1
    end

    # 廣度優先搜索
    until queue.empty?
      row, col = queue.shift

      # 到達底部
      return true if row == max_row - 1

      # 檢查四個方向
      [[row + 1, col], [row - 1, col], [row, col + 1], [row, col - 1]].each do |new_row, new_col|
        if new_row.between?(0, max_row - 1) && new_col.between?(0, max_col - 1) && grid_array[new_row][new_col] == 1
          queue.push([new_row, new_col])
          grid_array[new_row][new_col] = 0 # 標記已訪問
        end
      end
    end

    false
  end
end
