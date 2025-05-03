def stockpicker(stock_array)
  delta_array = []
  i = 0
  while i < (stock_array.length) -1
    max_diff = 0
    ii = i + 1
    while ii < stock_array.length
      if stock_array[ii] - stock_array[i] > max_diff
        max_diff = stock_array[ii] - stock_array[i] 
      end
      ii +=1
    end
    delta_array.push(max_diff)
    i +=1
  end
  buy_day = delta_array.index(delta_array.max)
  sell_day = stock_array.rindex((stock_array[buy_day] + delta_array[buy_day]))
  transactions = [buy_day, sell_day]
  return transactions
end

stocks = [17,3,6,9,15,8,6,1,10]
p stockpicker(stocks)