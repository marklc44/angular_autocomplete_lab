class WordsController < ApplicationController

  before_action :render_layout_if_html

  respond_to :json, :html

  def index
    respond_with Word.all
  end

  def create
    word_params = params.require(:word).permit(:name, :description)
    respond_with Word.create(word_params)
  end

  def show
    id = params[:id]
    respond_with Word.find_by_id(id)
  end

  private
    def render_layout_if_html
      if request.format.symbol == :html
        render "layouts/application"
      end
    end
end
