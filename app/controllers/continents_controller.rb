
class ContinentsController < ApplicationController
  # GET /continents
  # GET /continents.json
  def index
    @continents = Continent.includes(:countries).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @continents }
    end
  end

  # GET /continents/1
  # GET /continents/1.json
  def show
    @continent = Continent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @continent }
    end
  end

  # GET /continents/new
  # GET /continents/new.json
  def new
    @continent = Continent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @continent }
    end
  end

  # GET /continents/1/edit
  def edit
    @continent = Continent.find(params[:id])
  end

  # POST /continents
  # POST /continents.json
  def create
    @continent = Continent.new(params[:continent])

    respond_to do |format|
      if @continent.save
        format.html { redirect_to @continent, notice: 'Continent was successfully created.' }
        format.json { render json: @continent, status: :created, location: @continent }
      else
        format.html { render action: "new" }
        format.json { render json: @continent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /continents/1
  # PUT /continents/1.json
  def update
    @continent = Continent.find(params[:id])

    respond_to do |format|
      if @continent.update_attributes(params[:continent])
        format.html { redirect_to @continent, notice: 'Continent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @continent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /continents/1
  # DELETE /continents/1.json
  def destroy
    @continent = Continent.find(params[:id])
    @continent.destroy

    respond_to do |format|
      format.html { redirect_to continents_url }
      format.json { head :no_content }
    end
  end
end
