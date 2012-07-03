
class AccesstokensController < ApplicationController
  # GET /accesstokens
  # GET /accesstokens.json
  def index
    @accesstokens = Accesstoken.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accesstokens }
    end
  end

  # GET /accesstokens/1
  # GET /accesstokens/1.json
  def show
    @accesstoken = Accesstoken.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @accesstoken }
    end
  end

  # GET /accesstokens/new
  # GET /accesstokens/new.json
  def new
    @accesstoken = Accesstoken.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accesstoken }
    end
  end

  # GET /accesstokens/1/edit
  def edit
    @accesstoken = Accesstoken.find(params[:id])
  end

  # POST /accesstokens
  # POST /accesstokens.json
  def create
    @accesstoken = Accesstoken.new(params[:accesstoken])

    respond_to do |format|
      if @accesstoken.save
        format.html { redirect_to @accesstoken, notice: 'Accesstoken was successfully created.' }
        format.json { render json: @accesstoken, status: :created, location: @accesstoken }
      else
        format.html { render action: "new" }
        format.json { render json: @accesstoken.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accesstokens/1
  # PUT /accesstokens/1.json
  def update
    @accesstoken = Accesstoken.find(params[:id])

    respond_to do |format|
      if @accesstoken.update_attributes(params[:accesstoken])
        format.html { redirect_to @accesstoken, notice: 'Accesstoken was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @accesstoken.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accesstokens/1
  # DELETE /accesstokens/1.json
  def destroy
    @accesstoken = Accesstoken.find(params[:id])
    @accesstoken.destroy

    respond_to do |format|
      format.html { redirect_to accesstokens_url }
      format.json { head :no_content }
    end
  end
end
