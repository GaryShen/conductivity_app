class GridEvaluationsController < ApplicationController
  def index
    @grid_evaluations = GridEvaluation.all

    @grid_evaluations = @grid_evaluations.paginate(page: params[:page], per_page: 10)
  end

  def new
    @grid_evaluation = GridEvaluation.new
  end

  def create
    grid_data = if params[:grid_evaluation] && params[:grid_evaluation][:grid_file]
                  read_grid_from_file(params[:grid_evaluation][:grid_file])
                else
                  params[:grid_evaluation][:grid]
                end

    @grid_evaluation = GridEvaluation.new(grid: grid_data.gsub(/\r\n?/, "\n"))

    if @grid_evaluation.save
      redirect_to @grid_evaluation
    else
      render :new
    end
  end

  def show
    @grid_evaluation = GridEvaluation.find(params[:id])
  end

  def generate_random_grid
    n = params[:n].to_i
    @random_grid = GridEvaluation.random_grid(n)
    render json: { grid: @random_grid }
  end

  private

  def read_grid_from_file(file)
    file.read
  end
end
