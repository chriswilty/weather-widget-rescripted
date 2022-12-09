%%raw("import './WeatherWidget.css'")

// TODO
// Invoke service in a useEffect hook, store in a useState
// Show Loading spinner until data arrives
@react.component
let make = () => {
	let weatherData = MockData.weatherData

	<div className="weather-widget">
		<WeatherPanel data={weatherData} />
	</div>
}
