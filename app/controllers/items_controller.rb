class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if params[:keyword].present? 
      @items = Item.search(params[:keyword]).paginate(:page => params[:page], :per_page => 5)
    elsif params[:category_id].present?
      @items = Item.filter(params[:category_id]).paginate(:page => params[:page], :per_page => 5) 
    else
      @items = Item.paginate(:page => params[:page], :per_page => 5)
    end

    @export_items = Item.all
    #respond_with(@items)
    respond_to do |format|
      format.html
      format.csv {send_data @export_items.to_csv}
      format.xls
    end
  end

  def show
    respond_with(@item)
  end

  def new
    @item = Item.new
    respond_with(@item)
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.save
    respond_with(@item)
  end

  def update
    @item.update(item_params)
    respond_with(@item)
  end

  def destroy
    @item.destroy
    respond_with(@item)
  end

  def import
    Item.import(params[:file])
    redirect_to root_url, notice: "Products imported." 
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:code, :description, :price, :uploaded_file, :category_id)
    end

    def filtering_params(params)
      params.slice(:keyword, :searchdescr, :searchcateg)
    end
end
