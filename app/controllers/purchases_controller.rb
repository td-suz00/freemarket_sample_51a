class PurchasesController < ApplicationController
  def new
    @item = Item.find(4)
    #### 仮置き Item.find(params[:item_id])
    render layout: 'application-off-header-footer.haml'
  end
end
