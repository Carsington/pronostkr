const placeForecast = () => {
  const elements = document.getElementsByClassName('team-card');
  console.log(elements[0]);
  for (let i = 0; i < elements.length; i++) {
    elements[i].addEventListener("click", (event) => {
      event.currentTarget.classList.toggle("forecast-placed")
    });
  }
}

export { placeForecast };
