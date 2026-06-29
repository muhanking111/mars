import type { CustomRoute } from '@elegant-router/types';
import { layouts, views } from '../elegant/imports';
import { getRoutePath, transformElegantRoutesToVueRoutes } from '../elegant/transform';
import { localStg } from '@/utils/storage';

export const ROOT_ROUTE: CustomRoute = {
  name: 'root',
  path: '/',
  redirect: () => {
    const token = localStg.get('token');
    return token ? '/home' : '/login';
  },
  meta: {
    title: 'root',
    constant: true
  }
};

const NOT_FOUND_ROUTE: CustomRoute = {
  name: 'not-found',
  path: '/:pathMatch(.*)*',
  component: 'layout.blank$view.404',
  meta: {
    title: 'not-found',
    constant: true
  }
};

/** builtin routes, it must be constant and setup in vue-router */
const builtinRoutes: CustomRoute[] = [
  ROOT_ROUTE, 
  NOT_FOUND_ROUTE,
  // iframe直接访问路由
  {
    name: 'iframe-direct',
    path: '/iframe-direct',
    component: 'layout.base$view.iframe-direct',
    meta: {
      title: 'iframe-direct',
      constant: true
    }
  } as unknown as CustomRoute
];

/** create builtin vue routes */
export function createBuiltinVueRoutes() {
  return transformElegantRoutesToVueRoutes(builtinRoutes, layouts, views);
}
