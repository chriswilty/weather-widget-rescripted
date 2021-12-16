%%raw("import '/src/styles/icons/owfont-regular.css'")

@react.component
let make = (~locations: array<WeatherTypes.weather>, ~currentIndex: int) => {
  <div className="weather-panel">
    <Location name={locations[currentIndex].location} />
  </div>
}
