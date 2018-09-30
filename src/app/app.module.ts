import { BrowserModule } from '@angular/platform-browser';
import { routing } from "./app.routing";
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from "@angular/forms";
import { HttpClientModule } from "@angular/common/http";

import { AppComponent } from './app.component';
import { ListCarsComponent } from './list-cars/list-cars.component';
import { CarService } from "./service/car.service";


@NgModule({
  declarations: [
    AppComponent,
    ListCarsComponent
  ],
  imports: [
    BrowserModule,
    routing,
    ReactiveFormsModule,
    HttpClientModule
  ],
  providers: [CarService],
  bootstrap: [AppComponent]
})
export class AppModule { }