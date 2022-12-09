%%raw("import '/src/styles/icons/owfont-regular.css'")
%%raw("import './weather-panel.css'")

module Dots = {
	@react.component
	let make = (~locations: array<string>, ~currentLocation: string, ~onSelected: string => unit) => {
		let selectors = Js.Array2.map(locations, location =>
			<input
				type_="radio"
				name="locations"
				key={location}
				value={location}
				title={location}
				checked={location == currentLocation}
				onChange={_ => onSelected(location)}
			/>
		)

		<div className="navigator" role="group" ariaLabel="location selector">
			{React.array(selectors)}
		</div>
	}
}

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

		<div role="region" ariaLabel="temperature" className="temperature">
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
		let normalisedDirection = Js.Int.toString(mod(fromDegrees, 360))
		let windIconStyle = ReactDOM.Style.make(
			~transform="rotate(" ++ normalisedDirection ++ "deg)",
			(),
		)
		let windIconDescription = "Direction " ++ normalisedDirection ++ " degrees (North being 0)"

		<div role="region" ariaLabel="wind" className="wind">
			<i title={windIconDescription} style={windIconStyle} className="icon" />
			<div className="speed" title="wind speed">
				{React.string(speed)}
				<span className="units"> {React.string(" m/s")} </span>
			</div>
		</div>
	}
}

@react.component
let make = (~data: array<WeatherTypes.weather>) => {
	let (currentIndex, setIndexRaw) = React.useState(_ => 0);
	let incrementIndex = () => setIndexRaw(prev => mod(prev + 1, Js.Array2.length(data)))
	let setIndex = index => setIndexRaw(_ => index)

	React.useEffect1(() => {
		let timer = Js.Global.setTimeout(incrementIndex, 3000)
		Some(() => Js.Global.clearTimeout(timer))
	}, [currentIndex])

	let {icon, location, temperature, wind} = data[currentIndex]
	let locations = Js.Array2.map(data, weather => weather.location)
	let setLocation = location =>
		locations
			-> Js.Array2.findIndex(loc => loc == location)
			-> setIndex

	<div className="weather-panel">
		<Location name={location} />
		<Wind wind />
		<WeatherIcon icon />
		<Temperature temperature />
		<Dots locations currentLocation={location} onSelected={setLocation} />
	</div>
}
