%%raw("import './WeatherWidget.css'")

// TODO Invoke service in a useEffect hook, store in a useState?
@react.component
let make = () => {
	<div className="weather-widget">
		<WeatherPanel locations={MockData.weatherData} currentIndex={0} />
	</div>
}