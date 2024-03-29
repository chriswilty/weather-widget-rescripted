%%raw("import '/src/styles/icons/owfont-regular.css'")
%%raw("import './WeatherPanel.css'")

module Navigator = {
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

		<div role="img" ariaLabel={"weather: " ++ description} className="weather-icon">
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
			~transform=`rotate(${normalisedDirection}deg)`, ()
		)
		let windIconDescription = `Direction ${normalisedDirection} degrees (Northerly being 0)`

		<div role="region" ariaLabel="wind" className="wind">
			<i
				role="img"
				ariaLabel={windIconDescription}
				title={windIconDescription}
				style={windIconStyle}
				className="icon"
			/>
			<div className="speed" title="wind speed">
				{React.string(speed)}
				<span className="units"> {React.string(" m/s")} </span>
			</div>
		</div>
	}
}

@react.component
let make = (~data: array<WeatherTypes.weather>) => {
	let (currentIndex, setIndex) = React.useState(_ => 0);
	let intervalId = React.useRef(None)

	let incrementIndex = () => setIndex(prev => mod(prev + 1, Js.Array2.length(data)))
	let startTicker = () => {
		intervalId.current = Some(Js.Global.setInterval(incrementIndex, 3000))
	}
	let stopTicker = () => switch intervalId.current {
		| Some(id) => Js.Global.clearInterval(id)
		| None => ()
	}

	React.useEffect0(() => {
		startTicker()
		Some(stopTicker)
	})

	let { icon, location: name, temperature, wind } = data[currentIndex]
	let locations = Js.Array2.map(data, weather => weather.location)
	let setLocation = location => {
		stopTicker()
		let newIndex = Js.Array2.findIndex(locations, loc => loc == location)
		setIndex(_ => newIndex >= 0 ? newIndex : 0)
		startTicker()
	}

	<div className="weather-panel">
		<Location name />
		<Wind wind />
		<WeatherIcon icon />
		<Temperature temperature />
		<Navigator locations currentLocation={name} onSelected={setLocation} />
	</div>
}
