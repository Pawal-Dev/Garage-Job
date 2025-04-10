let take_vehicle = null;
let garagenumber = null;
let carlabel = null;
let carnumber = null;

const prendre = function() {
    fermerMenu();   
    fetch(`https://${GetParentResourceName()}/spawncar`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            spawnname: take_vehicle,
            garagenumber: garagenumber,
            label: carlabel,
            number: parseInt(carnumber) + 1
        })
    })
}

function checkImage(url) {
    return new Promise((resolve) => {
        let img = new Image();
        img.onload = () => resolve(url);
        img.onerror = () => resolve("img/vehicle/default.png");
        img.src = url;
    });
}

window.addEventListener('message', async (event) => {
    let data = event.data

    if ( data.action === 'openmenu') {
        let actifbouton = document.getElementById("prendre_menu");
        let nocarfound = document.getElementById("no_vehicle");
        let listing = document.getElementById("listing_vehicle");
        listing.innerHTML = ""; 
        take_vehicle = null;
        garagenumber = null;
        carnumber = null;
        carlabel = null;

        const traduction = data.traduction;
        document.getElementById("prendre_menu").innerText = traduction.take;
        document.getElementById("quitter_menu").innerText = traduction.leave;

        document.getElementById("job_name").innerHTML = data.label;
        document.getElementById("img_header").src = data.header;
        actifbouton.removeEventListener("click", prendre);

        if (data.vehicle.length === 0){
            nocarfound.style.display = "flex";  
        } else {
            for (let key in data.vehicle) {
                let img = await checkImage(data.vehicle[key].img); 
                nocarfound.style.display = "none";         

                let add_list_car = `
                <div id="${data.vehicle[key].spawn}" class="vehicle_choix">
                    <a id="${data.garagenumber}" style="display:none">${data.garagenumber}</a>
                    <a id="${key}" style="display:none">${key}</a>
                    <img src="${img}" id="img_vehicle">
                    <div class="bottom_label">
                        <a id="label">${data.vehicle[key].label}</a>
                    </div>
                </div>
                `;
        
                listing.innerHTML += add_list_car;
            } 
        }
       
        let divs = document.querySelectorAll(".vehicle_choix");

        divs.forEach(div => {
            div.addEventListener("click", function () {

                document.getElementById("prendre_menu").addEventListener("click", prendre);

                divs.forEach(d => d.style.backgroundColor = "rgba(20, 20, 20, 0.616)");

                take_vehicle = this.id;

                let garageElement = this.querySelector("[id]"); 
                if (garageElement) {
                    garagenumber = garageElement.id
                }

                let carElements = this.querySelectorAll("a"); 

                if (carElements) {
                    carlabel = carElements[2].textContent;
                    carnumber = carElements[1].textContent
                }

                this.style.backgroundColor = "rgba(124, 170, 255, 0.226)";

                actifbouton.classList.add("actif");
                actifbouton.style.background = "linear-gradient(to bottom, rgb(55, 255, 65), rgb(48, 112, 40))";

                this.style.backgroundColor = "rgba(124, 170, 255, 0.226)";
            });
        });

        ouvrirMenu();  
    }
})

document.getElementById("quitter_menu").addEventListener("click", function() {
    fermerMenu();   
});

function ouvrirMenu() {
    let menu = document.getElementById("menu");

    menu.classList.add("fade-in");
    menu.classList.remove("fade-out"); 
    menu.style.opacity = "1";
}

function fermerMenu() {
    let actifbouton = document.getElementById("prendre_menu");
    actifbouton.classList.remove("actif");
    actifbouton.style.background = "linear-gradient(to bottom, rgb(153, 153, 153), rgb(124, 124, 124))"; 

    fetch(`https://${GetParentResourceName()}/closemenu`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
    })

    let menu = document.getElementById("menu");

    menu.classList.add("fade-out"); 
    menu.classList.remove("fade-in"); 
    menu.style.opacity = "0";
}