class CategoriesController < ApplicationController
 before_filter :set_admin

  def set_admin
    @is_admin = true
  end


  def index
    #@categories = Category.all
    @categories = Category.includes(:sub_categories).order(:name)
    authorize! :index, Category

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])
    authorize! :show, Category

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new
    #@categories = Category.all
    @categories = Category.includes(:sub_categories).order(:name)
    authorize! :new, Category

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
    authorize! :edit, Category
  end

  # POST /categories
  # POST /categories.json
  def create
    @cat = Category.where("name =?",params[:category][:name].to_s)

    if !@cat.present?
      @category = Category.new(params[:category])
    else
      @category = Category.find(@cat.first.id)  
    end
    authorize! :create, Category

    respond_to do |format|
      @status = @cat.present? ? @category.update_attributes(params[:category]) : @category.save
      if @status
        format.js
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])
    authorize! :update, Category

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    authorize! :destroy, Category
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :ok }
    end
  end
end
