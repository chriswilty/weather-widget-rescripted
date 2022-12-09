let useMockFetch = (data: 'a) => {
	let timeoutMillis = 1500
	let (responseData, setResponseData) = React.useState(() => None)
	let timeoutRef = React.useRef(None)

	React.useEffect0(() => {
		timeoutRef.current = Js.Global.setTimeout(() => {
			setResponseData(_ => Some(data))
		}, timeoutMillis)->Some

		Some(() => switch timeoutRef.current {
		| Some(timer) => Js.Global.clearTimeout(timer)
		| None => ()
		})
	})

	responseData
}
