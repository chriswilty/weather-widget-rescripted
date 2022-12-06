%%raw("import '/src/styles/icons/owfont-regular.css'")
%%raw("import './weather-panel.css'")

module Location = {
  @react.component
  let make = (~name: string) => {
    <div title="location"> {React.string(name)} </div>
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
      <i className="icon" style={windIconStyle} title={windIconDescription} />
      <div className="speed">
        {React.string(speed)}
        <span className="units"> {React.string(" m/s")} </span>
      </div>
    </div>
  }
}

@react.component
let make = (~locations: array<WeatherTypes.weather>, ~currentIndex: int) => {
  let {location, wind} = locations[currentIndex]

  <div className="weather-panel">
    <Location name={location} />
    <Wind wind />
  </div>
}