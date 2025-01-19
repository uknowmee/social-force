# Scope of the project

W raporcie opisano zagadnienie przepływu tłumu na terenie kampusu AGH z wykorzystaniem modelu Social Force. Wybrany model świetnie odzwierciedla rzeczywiste zachowanie pieszych, którzy raczej unikają kolizji ze sobą (jak w [@fig:laufer2008passenger-000]), niż starają się jak najszybciej dotrzeć do celu. Również w modelu Social Force agenci starają się utrzymać odpowiedni dystans od przeszkód, takich jak trawniki czy ściany, co jest zgodne z obserwacjami w rzeczywistości.

![Attributes of the Social Force Model [@laufer2008passenger]](images/laufer2008passenger-000.png){#fig:laufer2008passenger-000 width=75%}

Skupiono się na obszarze między budynkami A-0 a B-5. W ramach projektu zaimplementowano symulację przepływu 14 grup, z których każda składa się składa się z 45 agentów. Symulacja została wykonana z wykorzystaniem silnika gier Godot.

Agenci reprezentują społeczność uczelni, a ich zadaniem jest przejście z jednego z budynków uczelni do budynku Biblioteki Głównej AGH. Agentom nie wolno wchodzić do budynków ani na teren zielony, mogą natomiast poruszać się po asfalcie i chodnikach. W trakcie symulacji agenci muszą unikać kolizji z innymi agentami oraz przeszkodami na drodze.
