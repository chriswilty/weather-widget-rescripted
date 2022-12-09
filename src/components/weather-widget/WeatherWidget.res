%%raw("import './WeatherWidget.css'")

module Loading = {
	@react.component
	let make = () => {
		<div className="loading" />
	}
}

@react.component
let make = () => {
	let weatherData = Hooks.useMockFetch(MockData.weatherData)

	let content = switch weatherData {
	| None => <Loading />
	| Some(data) => <WeatherPanel data />
	}

	<div className="weather-widget">{content}</div>
}
