type weather_icon = {
	code: string,
	description: string
}

type temperature = {
	current: string,
	minimum: string,
	maximum: string
}

type wind = {
	speed: string,
	fromDegrees: int
}

type weather = {
	id: int,
	location: string,
	icon: weather_icon,
	temperature: temperature,
	wind: wind
}
