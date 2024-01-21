class GridEvaluation < ApplicationRecord
  serialize :result_path, coder: JSON

  validate :grid_format_valid, :grid_must_be_square

  before_save :set_result

  def self.random_grid(n)
    Array.new(n) { Array.new(n) { rand(0..1) }.join }.join("\n")
  end

  def bfs_path
    grid_array = self.grid.split("\n").map { |row| row.split('').map(&:to_i) }
    queue = []
    predecessor = {}
    path_found = false
    end_node = nil

    grid_array[0].each_with_index do |val, col|
      if val == 1
        queue.push([0, col])
        predecessor[[0, col]] = nil
      end
    end

    while !queue.empty? && !path_found
      row, col = queue.shift

      if row == grid_array.length - 1
        path_found = true
        end_node = [row, col]
        break
      end

      [[row + 1, col], [row, col + 1], [row - 1, col], [row, col - 1]].each do |new_row, new_col|
        if new_row.between?(0, grid_array.length - 1) &&
           new_col.between?(0, grid_array[0].length - 1) &&
           grid_array[new_row][new_col] == 1 &&
           !predecessor.has_key?([new_row, new_col])

          queue.push([new_row, new_col])
          predecessor[[new_row, new_col]] = [row, col]
        end
      end
    end

    return [] unless path_found

    path = []
    current_node = end_node
    while current_node
      path.unshift(current_node)
      current_node = predecessor[current_node]
    end

    path
  end

  def set_result
    path = bfs_path

    self.result = path.present?
    self.result_path = path
  end

  private

  def grid_format_valid
    return if grid.match(/\A[01\r\n]+\z/)

    errors.add(:grid, 'must only contain 0, 1, and newlines')
  end

  def grid_must_be_square
    rows = grid.split("\n")
    return errors.add(:grid, 'cannot be empty') if rows.empty?

    length = rows.first.length
    return if rows.all? { |row| row.length == length }

    errors.add(:grid, 'must be a square (N x N grid)')
  end
end
