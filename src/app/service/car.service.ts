import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { Car } from "../model/car.model";

@Injectable()
export class CarService {
  constructor(private http: HttpClient) { }
  baseUrl: string = 'http://localhost:8080/car-portal/cars';

  getCars() {
   let fakeCars = [{id: 1, carName: 'Dacia', carModel: 'Logan'},
     {id: 2, carName: 'Dacia', carModel: 'Sandero'},
     {id: 3, carName: 'Dacia', carModel: 'Lodji'},
     {id: 4, carName: 'Skoda', carModel: 'Fabia'},
   ];
   return of(fakeCars);
    /* return this.http.get<User[]>(this.baseUrl); */
  }

  getCarById(id: number) {
    return this.http.get<Car>(this.baseUrl + '/' + id);
  }

  createCar(car: Car) {
    return this.http.post(this.baseUrl, car);
  }

  updateCar(car: Car) {
    return this.http.put(this.baseUrl + '/' + car.id, car);
  }

  deleteCar(id: number) {
    return this.http.delete(this.baseUrl + '/' + id);
  }
}