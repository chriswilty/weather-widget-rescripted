%%raw("import './App.css'")

@react.component
let make = () => {
	<div className="app">
		<div className="app-content">
			<WeatherWidget />
		</div>
	</div>
}
