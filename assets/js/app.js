// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: {
  HeadComponent: {
    mounted() {
      console.debug("Head mounted");
      document.getElementById('surface').addEventListener("click", function clickRecordCoordinate({offsetX, offsetY}) {
        console.debug("Recorded click");
        document.getElementById('entry-form_x').value = offsetX;
        document.getElementById('entry-form_y').value = offsetY;
        document.getElementById('entry-form_x').dispatchEvent(new Event('change', {bubbles: true}));
        document.getElementById('entry-form_y').dispatchEvent(new Event('change', {bubbles: true}));
      });
    }
  },
  TimelineComponent:  {
    mounted() {
      console.debug("Timeline mounted");
      this.handleEvent("load-timeline-data", ({datasets, labels}) => {
        console.debug("Timeline loaded", datasets)
        new Chart(this.el, {
          type: "line",
          data: {
            labels,
            datasets
          },
          options: {
            spanGaps: 1000 * 60 * 60 * 24, // 1 days
            plugins: {
              zoom: {
                zoom: {
                  wheel: {
                    enabled: true,
                  },
                  pinch: {
                    enabled: true
                  },
                  mode: 'x'
                },
                pan: {
                  enabled: true,
                  mode: 'x'
                }
              }
            },
            scales: {
              y: {
                min: 0,
                max: 10
              },
              x: {
                type: 'time',
                display: true,
                title: {
                  display: true,
                  text: 'Date'
                },
                ticks: {
                  autoSkip: false,
                  maxRotation: 0,
                  major: {
                    enabled: true
                  },
                  font: function(context) {
                    if (context.tick && context.tick.major) {
                      return {
                        weight: 'bold',
                      };
                    }
                  }
                }
              }
            }
          }
        });
      });
      this.pushEventTo("#timeline", "request-timeline-data", {});
    }
  }
}})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.delayedShow(200))
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket
