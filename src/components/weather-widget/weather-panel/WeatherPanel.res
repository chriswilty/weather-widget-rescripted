%%raw("import '/src/styles/icons/owfont-regular.css'")
%%raw("import './weather-panel.css'")

module Location = {
  @react.component
  let make = (~name: string) => {
    <div title="location" className="location"> {React.string(name)} </div>
  }
}

module Temperature = {
  @react.component
  let make = (~temperature: WeatherTypes.temperature) => {
    let {minimum, current, maximum} = temperature
    let degrees = "\u00B0c"

    <div title="temperature" role="region" className="temperature">
      <div title={"minimum " ++ degrees} className="min"> {React.string(minimum)} </div>
      <div title="current" className="current"> {React.string(current ++ degrees)} </div>
      <div title={"maximum " ++ degrees} className="max"> {React.string(maximum)} </div>
    </div>
  }
}

module WeatherIcon = {
  @react.component
  let make = (~icon: WeatherTypes.weather_icon) => {
    let {code, description} = icon

    <div className="icon">
      <i title={description} className={"owf owf-5x owf-" ++ code} />
    </div>
  }
}

module Wind = {
  @react.component
  let make = (~wind: WeatherTypes.wind) => {
    let {fromDegrees, speed} = wind
    let normalisedDirection = Js.Int.toString(mod(fromDegrees, 360)) ++ "deg"
    let windIconStyle = ReactDOM.Style.make(~transform="rotate(" ++ normalisedDirection ++ ")", ())
    let windIconDescription = "direction: " ++ normalisedDirection

    <div className="wind">
      <i title={windIconDescription} style={windIconStyle} className="icon" />
      <div className="speed">
        {React.string(speed)}
        <span className="units"> {React.string(" m/s")} </span>
      </div>
    </div>
  }
}

@react.component
let make = (~locations: array<WeatherTypes.weather>, ~currentIndex: int) => {
  let {icon, location, temperature, wind} = locations[currentIndex]

  <div className="weather-panel">
    <Location name={location} />
    <Wind wind />
    <WeatherIcon icon />
    <Temperature temperature />
  </div>
}