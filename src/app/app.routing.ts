import { RouterModule, Routes } from '@angular/router';
import { ListCarsComponent } from "./list-cars/list-cars.component";

const routes: Routes = [
  {path : '', component : ListCarsComponent}
];

export const routing = RouterModule.forRoot(routes);