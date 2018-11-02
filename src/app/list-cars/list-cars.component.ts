import { Component, OnInit } from '@angular/core';
import { Router } from "@angular/router";
import { CarService } from "../service/car.service";
import { Car } from "../model/car.model";


@Component({
  selector: 'app-list-cars',
  templateUrl: './list-cars.component.html',
  styleUrls: ['./list-cars.component.css']
})
export class ListCarsComponent implements OnInit {

  cars: Car[];

  constructor(private router: Router, private carService: CarService) { }

  ngOnInit() {
    this.carService.getCars()
      .subscribe( data => {
        this.cars = data;
      });
  }

  deleteCar(car: Car): void {
    this.carService.deleteCar(car.id)
      .subscribe( data => {
        this.cars = this.cars.filter(u => u !== car);
      })
  };

  editCar(car: Car): void {
    localStorage.removeItem("editCarId");
    localStorage.setItem("editCarId", car.id.toString());
    this.router.navigate(['edit-car']);
  };

  addCar(): void {
    this.router.navigate(['add-car']);
  };

}
