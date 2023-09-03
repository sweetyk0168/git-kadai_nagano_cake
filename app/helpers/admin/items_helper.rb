module Admin::ItemsHelper
  def item_status_name(item)
    if item.is_active
      '販売中'
    else
      '販売停止中'
    end
  end
end
