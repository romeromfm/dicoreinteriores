class BlogController < ApplicationController
  layout "blog"

  before_action :load_archives, :load_categories, only: :index

  def index    
    @posts = Post.published_ordered.page(params.fetch(:page, 1))
  end

  def show
    @post = Post.find_by_id_and_draft!(params[:id], false)
  end

  def by_category    
    @posts = Post.where(category: params[:category]).page(params.fetch(:page, 1))
    render 'index'
  end

  def tag
    @posts = Post.tagged_with(params[:tag]).published_ordered.page(params.fetch(:page, 1))
    render 'index'
  end

  private

  def load_archives    
    @archives = PostQuery.new.search.archives
  end

  def load_categories
    @categories = Category.all
  end
end