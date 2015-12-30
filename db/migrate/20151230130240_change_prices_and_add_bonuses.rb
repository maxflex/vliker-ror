class ChangePricesAndAddBonuses < ActiveRecord::Migration
  def change
    GoodType.update(4, type_id: 129)
    GoodType.update(3, price: 0.07)
    GoodType.update(1, price: 0.08)
    Good.where(id: 7..12).update_all(bonus: '100')
  end
end
