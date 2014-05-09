module ProjectHelper
  def get_percent(count, total)
    return 100 if count == total
    return ((count.to_f/total.to_f).round(2) * 100).to_i
  end
end