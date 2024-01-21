class GridEvaluation < ApplicationRecord
  before_save :set_result

  def self.random_grid(n)
    Array.new(n) { Array.new(n) { rand(0..1) }.join }.join("\n")
  end

  def bfs_path
    path = []
    grid_array = self.grid.split("\n").map { |row| row.split('').map(&:to_i) }
    visited = Array.new(grid_array.length) { Array.new(grid_array[0].length, false) }
    queue = []

    grid_array[0].each_with_index do |val, col|
      if val == 1
        queue.push([0, col])
        visited[0][col] = true
      end
    end

    until queue.empty?
      row, col = queue.shift
      path << [row, col]

      return path if row == grid_array.length - 1

      [[row + 1, col], [row, col + 1], [row - 1, col], [row, col - 1]].each do |new_row, new_col|
        if new_row.between?(0, grid_array.length - 1) && new_col.between?(0, grid_array[0].length - 1) && grid_array[new_row][new_col] == 1 && !visited[new_row][new_col]
          queue.push([new_row, new_col])
          visited[new_row][new_col] = true
        end
      end
    end

    []
  end

  def set_result
    self.result = bfs_path.present?
  end
end
