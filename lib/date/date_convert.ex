defprotocol Timex.Date.Convert do
  def to_gregorian(date)
  def to_erlang_datetime(date)
end

defimpl Timex.Date.Convert, for: Timex.DateTime do
  alias Timex.DateTime,     as: DateTime
  alias Timex.Timezone,     as: Timezone
  alias Timex.TimezoneInfo, as: TimezoneInfo
  
  def to_gregorian(
    %DateTime{
      :year => y, :month => m, :day => d, :hour => h, :minute => min, :second => sec,
      :timezone => %TimezoneInfo{:abbreviation => abbrev, :offset => {type, {_,_,_}=timestamp}}
    } = date) do
      { {y, m, d}, {h, min, sec}, {Time.to_hours(timestamp), abbrev}}
  end
  def to_erlang_datetime(%DateTime{:year => y, :month => m, :day => d, :hour => h, :minute => min, :second => sec}) do
    { {y, m, d}, {h, min, sec} }
  end
end