
class LogpagesController < ApplicationController
  # GET /logpages
  # GET /logpages.json
  def index
    @logpages = Logpage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logpages }
    end
  end

  # GET /logpages/1
  # GET /logpages/1.json
  def show
    @logpage = Logpage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @logpage }
    end
  end

  # GET /logpages/new
  # GET /logpages/new.json
  def new
    @logpage = Logpage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @logpage }
    end
  end

  # GET /logpages/1/edit
  def edit
    @logpage = Logpage.find(params[:id])
  end

  # POST /logpages
  # POST /logpages.json
  def create
    @logpage = Logpage.new(params[:logpage])

    respond_to do |format|
      if @logpage.save
        format.html { redirect_to @logpage, notice: 'Logpage was successfully created.' }
        format.json { render json: @logpage, status: :created, location: @logpage }
      else
        format.html { render action: "new" }
        format.json { render json: @logpage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /logpages/1
  # PUT /logpages/1.json
  def update
    @logpage = Logpage.find(params[:id])

    respond_to do |format|
      if @logpage.update_attributes(params[:logpage])
        format.html { redirect_to @logpage, notice: 'Logpage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @logpage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logpages/1
  # DELETE /logpages/1.json
  def destroy
    @logpage = Logpage.find(params[:id])
    @logpage.destroy

    respond_to do |format|
      format.html { redirect_to logpages_url }
      format.json { head :no_content }
    end
  end
end
